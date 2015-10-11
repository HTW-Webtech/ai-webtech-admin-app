require 'openssl'

module Apiv1
  class ClientAuth
    attr_reader :instance

    def initialize
      @instance = CipherBase64::Instance.new(auth_files_path)
    end

    def valid?(signature_base64, data)
      instance.valid?(signature_base64, data)
    end

    def auth_files_path
      Rails.root + "config/apiv1-auth"
    end
  end
end
