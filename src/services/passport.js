const passport = require("passport");
const OAuth2Strategy = require("passport-google-oauth").OAuth2Strategy;

const clientID = process.env.GOOGLE_CLIENT_ID;
const clientSecret = process.env.GOOGLE_CLIENT_SECRET;
const callbackURL = process.env.GOOGLE_CLIENT_CALLBACK;

const strategyConfig = new OAuth2Strategy(
  {
    clientID,
    clientSecret,
    callbackURL,
    scope: ["profile","email"],
  },
  (accessToken, refreshToken, profile, done) => {
    console.log("profile");
    done(null,profile)
  }
);

module.exports ={
  loginGoogleInitialize : () =>passport.use(strategyConfig)
} 
