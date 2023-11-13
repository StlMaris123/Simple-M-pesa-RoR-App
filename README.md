# README

### prerequisites
- Rails 7.1.1
- Ruby 3.0.2
  
Ensure that all environment variables are properly configured  by running:

  `EDITOR="code --wait" rails credentials:edit --environment=development`
Replace "code" with your favorite text editor.

The variables include:
```
twilio:
  account_sid: 
  auth_token: 
  phone_number: 

mpesa:
  consumer_key: 
  consumer_secret: 
  initiator_name: 
  initiator_password: 
  phone_number: 
  business_short_code: 
  pass_key: 
  callback_url: 
  stk_push_url: 
  oauth_url: 

gmail:
  username: 
  password:
```
They are found on [Twilio](https://www.twilio.com/docs/sms/api/message-resource) and [Daraja 2.0](https://developer.safaricom.co.ke/) documentation respectively. 

### User Flow/ Features
1. User registers
   - associated account(wallet) is created
2. User signs in
3. Load account using m-pesa stk push
4. Transfers between users
   - Recipients get both sms and email confirmation
5. Fetch the history of the transactions (statements)

For further details on the above, checkout the endpoints [here](https://bit.ly/3QWdEoy)

