import requests
import json
from bs4 import BeautifulSoup
import logging

class QuantumNewsPoster:
    def __init__(self, aqora_host, news_host):
        self.aqora_host = aqora_host
        self.news_host = news_host
        self.session = requests.Session()
        self.existing_titles = self.get_story_titles()

    def login_user(self, username, password):
        login_query = {
            "query": f"""mutation {{
                loginUser(input:{{usernameOrEmail: "{username}", password: "{password}"}}) {{
                    node {{ id }}
                }}
            }}"""
        }
        headers = {'Content-Type': 'application/json'}
        response = self.session.post(f"{self.aqora_host}/graphql", json=login_query, headers=headers)
        bearer_token = response.headers.get('x-access-token')

        # Get callback url
        response = self.session.get(f"{self.news_host}/login/aqora_auth", allow_redirects=False)
        callback_params = response.headers.get('Location').split('?')[1]

        # Parse callback parameters
        params = dict(param.split('=') for param in callback_params.split('&'))

        # Authorize graphql query
        authorize_query = {
            "query": f"""mutation {{
                oauth2Authorize(input:{{clientId: "{params['client_id']}", state: "{params['state']}"}}) {{
                    redirectUri
                }}
            }}"""
        }
        headers = {'Content-Type': 'application/json', 'Authorization': f'Bearer {bearer_token}'}
        response = self.session.post(f"{self.aqora_host}/graphql", json=authorize_query, headers=headers)
        authorize_callback = json.loads(response.text)['data']['oauth2Authorize']['redirectUri']

        # Final authorization callback
        self.session.get(authorize_callback)

    def get_story_titles(self):
        response = self.session.get(f"{self.news_host}/")  # Update with the correct URL if needed
        soup = BeautifulSoup(response.text, 'html.parser')
        story_titles = [a.get_text().strip() for a in soup.select('.story .details .link a')]
        return story_titles

    def post_story(self, story_info):
        # Get CSRF token
        response = self.session.get(f"{self.news_host}/stories/new")
        csrf_token = response.text.split('csrf-token" content="')[1].split('"')[0]

        url = story_info['link']
        description = story_info['description']
        tags = story_info['tags']

        # Fetch URL title
        response = self.session.post(
            f"{self.news_host}/stories/fetch_url_attributes",
            headers={"X-CSRF-Token": csrf_token},
            files={"fetch_url": (None, url)}
        )

        try:
            url_title = json.loads(response.text)['title']
        except json.JSONDecodeError:
            logging.error("Failed to decode JSON. Response was:", response.text)
            return

        # Check if the story title is already in the list
        if url_title in self.existing_titles:
            logging.info(f"Story '{url_title}' already exists. Not posting.")
            return

        # Post story
        story_data = {
            "authenticity_token": csrf_token,
            "story[url]": url,
            "story[title]": url_title,
            "story[description]": description,
            "story[tags_a][]": tags,
            "story[user_is_author]": "0",
            "story[user_is_following]": "0",
            "commit": "Submit"
        }
        self.session.post(f"{self.news_host}/stories", data=story_data, headers={"X-CSRF-Token": csrf_token})
        logging.info(f"Posted story: {url}")


