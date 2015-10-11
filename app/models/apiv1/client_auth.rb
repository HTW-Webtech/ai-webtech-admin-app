require 'openssl'

module Apiv1
  class ClientAuth
    attr_reader :auth_files_path

    def initialize(auth_files_path = 'config/apiv1-auth')
      @auth_files_path = auth_files_path
    end

    def valid?(base64_challenge, decrypted)
      challenge = Base64.decode64(base64_challenge)
      decrypt(challenge) == decrypted
    end

    def base64_encrypt(data)
      Base64.encode64 encrypt(data)
    end

    def encrypt(data)
      cipher = encryption_cipher
      cipher.update data
      cipher.final
    end

    def decrypt(data)
      cipher = decryption_cipher
      cipher.update data
      cipher.final
    end

    def decryption_cipher
      cipher { |c| c.decrypt }
    end

    def encryption_cipher
      cipher { |c| c.encrypt }
    end

    def cipher
      cipher = OpenSSL::Cipher.new 'aes-256-cbc'
      yield cipher
      cipher.iv = iv
      cipher.key = key
      cipher
    end

    def iv
      read_file 'b64_iv'
    end

    def key
      read_file 'b64_key'
    end

    private

    def read_file(name)
      file_path = Rails.root + "#{auth_files_path}/#{name}"
      base64_content = File.read(file_path)
      Base64.decode64 base64_content
    end
  end
end
