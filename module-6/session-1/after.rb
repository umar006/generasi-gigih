 # save user with auto generated password if user does not give password on registration.
 # default role is temp
 # return error if user email/username/phone is empty.
 def register_user(params)
   user = Data.new(params)
   # user.role = "admin"

   if user.password.blank?
     user.generate_password
   end

   email? = user.email.blank?
   username? = user.username.blank?
   phone? = user.phone.blank?

   if email? || username? || phone?
     raise Error::InvalidUserError
   end

   email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   email_match? = !(user.email.match(email_regex))
   phone_regex = /\A\+?[\d\s\-\.\(\)]+\z/
   phone_match? = !(user.phone.match(phone_regex))

   if email_match? || phone_match?
     raise Error::InvalidUserError
   end

   sql = "select count(1) from users where phone=#{user.phone} or email=#{user.email}"
   if Data.query(sql) > 0
     raise Error::DuplicateUser
   end

   user.save
   user.send_mail_cnfrm
   user
end
