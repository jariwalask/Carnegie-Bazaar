require 'digest/sha1'

class Member < ActiveRecord::Base
  has_many :Transactions
  has_many :Items, :dependent => :destroy


attr_accessor :password_confirmation
validates_confirmation_of :password
validates_presence_of :fname, :lname
validates_presence_of :email, :phone, :unless => :pass_submit
validates_presence_of :username, :password, :unless => :force_submit
attr_accessor :force_submit
attr_accessor :pass_submit
validates_length_of :fname, :lname, :username, :maximum => 10
validates_length_of :email, :maximum => 30, :unless => :pass_submit
validates_uniqueness_of :username, :email, :unless => :pass_submit
validates_format_of :fname, :lname, :with => /\A[a-zA-Z]+\z/
validates_format_of :email, :with => /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.edu$/, :unless => :pass_submit
validates_length_of :password, :minimum => 6, :unless => :force_submit
validates_length_of :password, :maximum => 25, :unless => :force_submit
validates_format_of :phone, :with => /^[3,5,7,4,6,8][0-9]{6}/, :unless => :pass_submit

def self.authenticate(username, password)
member = self.find_by_username(username)
if member
expected_password = encrypted_password(password, member.salt)
if member.hashed_password != expected_password
member = nil
end
end
member
end

def password
@password
end

def password=(pwd)
@password = pwd
return if pwd.blank?
create_new_salt
self.hashed_password = Member.encrypted_password(self.password, self.salt)
save(false)
end

def create_reset_code
  @reset=true
  self.attributes = {:ResetCode => Digest::SHA1.hexdigest(Time.now.to_s.split().sort_by{rand}.join)}
  save(false)
end

def delete_reset_code
  self.attributes = {:ResetCode => nil}
  save(false)
end



private

def password_non_blank
errors.add_to_base("Missing password" ) if hashed_password.blank?
end

def create_new_salt
self.salt = self.object_id.to_s + rand.to_s
end

def self.encrypted_password(password, salt)
string_to_hash = password + "wibble" + salt
Digest::SHA1.hexdigest(string_to_hash)
end

end
