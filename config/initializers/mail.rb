if Rails.env.production?
	ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.smtp_settings = {
	# メールアドレスが
		address: "smtp.gmail.com",
		domain: "gmail.com",
		port: 587,
		user_name: "Gmailのメールアドレス",
		password: "Gmailのパスワード",
		authentication: "plain",
		enable_starttls_auto: true
	}
elsif Rails.env.development?
	ActionMailer::Base.delivery_method = :letter_otener
else
	ActionMailer::Base.delivery_method = :test
end