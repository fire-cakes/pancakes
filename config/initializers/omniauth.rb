Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '775140832773880', '776b58e68047a09259c8184026043e01',
           scope: 'email,user_birthday', display: 'popup'
end
