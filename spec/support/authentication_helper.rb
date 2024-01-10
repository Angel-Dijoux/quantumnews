# typed: false

module AuthenticationHelper
  module FeatureHelper
    def stub_login_as(user)
      visit "/test/login?username=#{user.username}"
    end
  end

  module RequestHelper
    def sign_in(user)
      get '/test/login', params: { username: user.username }
    end
  end
end
