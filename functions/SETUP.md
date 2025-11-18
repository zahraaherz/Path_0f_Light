# Firebase Cloud Functions Setup Guide

This guide will help you set up and configure the Firebase Cloud Functions for the Path of Light application.

## Prerequisites

- Node.js 18 or higher
- Firebase CLI installed (`npm install -g firebase-tools`)
- Firebase project created
- Access to Firebase Console

## Installation

1. **Install dependencies:**
   ```bash
   cd functions
   npm install
   ```

2. **Configure Firebase:**
   ```bash
   firebase login
   firebase use <your-project-id>
   ```

## Environment Configuration

### Method 1: Firebase Functions Config (Recommended for Production)

Set configuration values using Firebase CLI:

```bash
# Email Service
firebase functions:config:set email.host="smtp.gmail.com"
firebase functions:config:set email.port="587"
firebase functions:config:set email.user="your-email@example.com"
firebase functions:config:set email.pass="your-app-password"

# RevenueCat Webhook
firebase functions:config:set revenuecat.webhook_secret="your-webhook-secret"

# View current configuration
firebase functions:config:get
```

### Method 2: Environment Variables (Local Development)

1. Copy the example file:
   ```bash
   cp .env.example .env
   ```

2. Edit `.env` and fill in your values:
   ```bash
   nano .env  # or use your preferred editor
   ```

3. Never commit `.env` to version control (already in .gitignore)

## Required Configurations

### 1. Email Service (Gmail Example)

For Gmail, you need to:
1. Enable 2-factor authentication on your Google account
2. Generate an App Password:
   - Go to https://myaccount.google.com/security
   - Select "2-Step Verification" → "App passwords"
   - Generate a new app password
   - Use this password in your configuration

```bash
firebase functions:config:set email.user="your-email@gmail.com"
firebase functions:config:set email.pass="your-app-password"
```

### 2. RevenueCat Webhook Secret

1. Log in to RevenueCat Dashboard
2. Go to Settings → Webhooks
3. Copy the "Authorization Header" secret
4. Configure it:

```bash
firebase functions:config:set revenuecat.webhook_secret="your-secret"
```

### 3. Admin User Setup

After deployment, set admin custom claims for authorized users:

```bash
# Using Firebase CLI
firebase auth:export users.json
# Edit users.json to add custom claims
firebase auth:import users.json --hash-algo=SCRYPT
```

Or use a Cloud Function to set admin claims (create one-time setup function):

```typescript
// One-time admin setup function
export const setAdminClaim = functions.https.onCall(async (data, context) => {
  // Add your security checks here
  await admin.auth().setCustomUserClaims(data.uid, { role: 'admin' });
  return { success: true };
});
```

## Building and Testing

### Build TypeScript:
```bash
npm run build
```

### Run Tests:
```bash
npm test                 # Run tests once
npm run test:watch       # Run tests in watch mode
npm run test:coverage    # Run tests with coverage report
```

### Local Development:
```bash
npm run serve            # Start Firebase emulators
```

### Deploy to Firebase:
```bash
# Deploy all functions
firebase deploy --only functions

# Deploy specific function
firebase deploy --only functions:functionName
```

## Security Checklist

Before deploying to production:

- [ ] Email credentials configured and tested
- [ ] RevenueCat webhook secret set
- [ ] Admin users configured with custom claims
- [ ] Rate limiting verified
- [ ] Storage rules deployed
- [ ] Firestore rules deployed
- [ ] All TODOs in code addressed
- [ ] Tests passing
- [ ] Environment variables documented
- [ ] Secrets not committed to git

## Monitoring and Logging

### View Logs:
```bash
firebase functions:log
```

### View Specific Function Logs:
```bash
firebase functions:log --only functionName
```

### Set Up Alerts (Firebase Console):
1. Go to Firebase Console → Functions
2. Set up alerts for errors, timeouts, etc.
3. Configure notification channels (email, Slack, etc.)

## Common Issues

### Issue: Function timeout
**Solution:** Increase timeout in function configuration:
```typescript
export const myFunction = functions
  .runWith({ timeoutSeconds: 300 })
  .https.onCall(async (data, context) => {
    // ...
  });
```

### Issue: Rate limiting not working
**Solution:** Ensure rate-limiter-flexible is installed:
```bash
npm install rate-limiter-flexible
```

### Issue: Email not sending
**Solution:**
1. Check email credentials
2. Verify SMTP settings
3. Check Gmail security settings (App Passwords)
4. Review function logs for errors

### Issue: Admin checks failing
**Solution:** Ensure custom claims are set correctly:
```bash
# Verify user claims
firebase auth:export users.json
# Check the customClaims field in users.json
```

## Production Deployment Checklist

- [ ] Update Node.js version in package.json engines
- [ ] Set all environment variables
- [ ] Configure custom domain (optional)
- [ ] Set up monitoring and alerts
- [ ] Configure backup strategy
- [ ] Document API endpoints
- [ ] Set up CI/CD pipeline
- [ ] Review security rules
- [ ] Load testing completed
- [ ] Error handling tested
- [ ] Rate limiting tested

## Updating Dependencies

```bash
# Check for outdated packages
npm outdated

# Update to latest versions
npm update

# Update major versions (be careful!)
npm install firebase-admin@latest firebase-functions@latest
```

## Support

For issues or questions:
1. Check Firebase documentation: https://firebase.google.com/docs/functions
2. Review function logs
3. Check GitHub issues
4. Contact development team

## Additional Resources

- [Firebase Functions Documentation](https://firebase.google.com/docs/functions)
- [TypeScript Guide](https://www.typescriptlang.org/docs/)
- [Firebase Security Rules](https://firebase.google.com/docs/rules)
- [RevenueCat Documentation](https://docs.revenuecat.com/)
