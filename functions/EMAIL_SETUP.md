# Email Service Setup Guide

This guide explains how to configure the email service for Path of Light to send verification and password reset emails.

## Overview

The email service uses **Nodemailer** to send emails. It's configured to work with any SMTP server, including:
- Gmail SMTP
- SendGrid
- Mailgun
- AWS SES
- Custom SMTP servers

## Quick Setup (Gmail)

### 1. Create an App Password

If using Gmail:

1. Go to your Google Account settings
2. Navigate to **Security** → **2-Step Verification**
3. Scroll down to **App passwords**
4. Generate a new app password for "Mail"
5. Save the 16-character password

### 2. Configure Firebase Functions

Set the email configuration using Firebase CLI:

```bash
cd functions

# Set email configuration
firebase functions:config:set \
  email.host="smtp.gmail.com" \
  email.port="587" \
  email.secure="false" \
  email.user="your-email@gmail.com" \
  email.pass="your-app-password" \
  email.from="your-email@gmail.com" \
  email.from_name="Path of Light"
```

### 3. Verify Configuration

Check your configuration:

```bash
firebase functions:config:get
```

You should see:

```json
{
  "email": {
    "host": "smtp.gmail.com",
    "port": "587",
    "secure": "false",
    "user": "your-email@gmail.com",
    "pass": "••••••••",
    "from": "your-email@gmail.com",
    "from_name": "Path of Light"
  }
}
```

### 4. Deploy Functions

```bash
npm run build
firebase deploy --only functions
```

## Advanced Setup Options

### Option 1: SendGrid

SendGrid is recommended for production use.

1. Sign up at https://sendgrid.com
2. Create an API key
3. Configure:

```bash
firebase functions:config:set \
  email.host="smtp.sendgrid.net" \
  email.port="587" \
  email.secure="false" \
  email.user="apikey" \
  email.pass="YOUR_SENDGRID_API_KEY" \
  email.from="noreply@yourdomain.com" \
  email.from_name="Path of Light"
```

### Option 2: Mailgun

1. Sign up at https://mailgun.com
2. Get SMTP credentials
3. Configure:

```bash
firebase functions:config:set \
  email.host="smtp.mailgun.org" \
  email.port="587" \
  email.secure="false" \
  email.user="postmaster@your-domain.mailgun.org" \
  email.pass="YOUR_MAILGUN_PASSWORD" \
  email.from="noreply@yourdomain.com" \
  email.from_name="Path of Light"
```

### Option 3: AWS SES

1. Set up AWS SES and verify your domain
2. Create SMTP credentials
3. Configure:

```bash
firebase functions:config:set \
  email.host="email-smtp.us-east-1.amazonaws.com" \
  email.port="587" \
  email.secure="false" \
  email.user="YOUR_SMTP_USERNAME" \
  email.pass="YOUR_SMTP_PASSWORD" \
  email.from="noreply@yourdomain.com" \
  email.from_name="Path of Light"
```

## Local Development

For local development with Firebase Emulators:

### 1. Download Functions Config

```bash
cd functions
firebase functions:config:get > .runtimeconfig.json
```

### 2. Start Emulators

```bash
firebase emulators:start
```

The email service will use the configuration from `.runtimeconfig.json`.

**Note:** Add `.runtimeconfig.json` to `.gitignore` to prevent committing sensitive data.

## Configuration Parameters

| Parameter | Description | Example |
|-----------|-------------|---------|
| `email.host` | SMTP server hostname | `smtp.gmail.com` |
| `email.port` | SMTP server port | `587` (TLS) or `465` (SSL) |
| `email.secure` | Use SSL? | `"true"` for port 465, `"false"` for port 587 |
| `email.user` | SMTP username | `your-email@gmail.com` |
| `email.pass` | SMTP password or API key | `your-app-password` |
| `email.from` | From email address | `noreply@yourdomain.com` |
| `email.from_name` | From display name | `Path of Light` |

## Testing Email Delivery

### Test Email Verification

Use Firebase Console or call the function directly:

```javascript
// From your app
const result = await functions.httpsCallable('sendEmailVerification')();
console.log(result.data);
```

### Test Password Reset

```javascript
// From your app
const result = await functions.httpsCallable('sendPasswordResetEmail')({
  email: 'user@example.com'
});
console.log(result.data);
```

## Email Templates

The email service includes professionally designed HTML email templates:

### Email Verification Template
- Professional design with Path of Light branding
- Clear call-to-action button
- Fallback text link
- Mobile-responsive
- Located in: `emailService.ts` → `getEmailVerificationTemplate()`

### Password Reset Template
- Security warning included
- Expiration notice (1 hour)
- Mobile-responsive design
- Located in: `emailService.ts` → `getPasswordResetTemplate()`

## Customizing Email Templates

To customize templates, edit the HTML in `emailService.ts`:

1. Open `functions/src/emailService.ts`
2. Find `getEmailVerificationTemplate()` or `getPasswordResetTemplate()`
3. Modify the HTML/CSS as needed
4. Run `npm run build` and redeploy

## Troubleshooting

### Emails Not Sending

1. **Check logs:**
   ```bash
   firebase functions:log
   ```

2. **Verify configuration:**
   ```bash
   firebase functions:config:get
   ```

3. **Test SMTP connection:**
   - Ensure firewall allows outbound connections on port 587/465
   - Verify SMTP credentials are correct
   - Check if 2FA is enabled (use app password for Gmail)

### Gmail Blocking Sign-ins

If using Gmail and emails aren't sending:

1. Use an **App Password** (not your regular password)
2. Enable **"Less secure app access"** (if app passwords aren't available)
3. Check for security alerts in your Google Account

### Configuration Not Found Warning

If you see "Email configuration not found" in logs:

- The email service will log email content to console instead of sending
- This is normal for development without configuration
- Set configuration using `firebase functions:config:set` commands above

## Production Best Practices

1. **Use a dedicated email service** (SendGrid, Mailgun, AWS SES)
2. **Don't use personal Gmail** for production emails
3. **Set up SPF, DKIM, and DMARC** records for your domain
4. **Monitor email delivery rates** and bounces
5. **Verify your domain** with your email service provider
6. **Use environment-specific configs** (dev, staging, production)
7. **Set up email analytics** to track open rates and clicks

## Security Notes

- Never commit email credentials to version control
- Use Firebase Functions config or environment variables
- Rotate credentials regularly
- Use app-specific passwords for Gmail
- Monitor for suspicious activity
- Consider rate limiting for email sending

## Cost Considerations

### Free Tiers

- **Gmail:** Free, but rate-limited (100-500 emails/day)
- **SendGrid:** 100 emails/day free
- **Mailgun:** 5,000 emails/month for 3 months free
- **AWS SES:** 62,000 emails/month free (when hosted on AWS)

### Recommendations

- **Development/Testing:** Gmail
- **Small Apps:** SendGrid free tier
- **Medium Apps:** Mailgun or SendGrid paid plans
- **Large Apps:** AWS SES (most cost-effective at scale)

## Support

For issues or questions:
- Check Firebase Functions logs: `firebase functions:log`
- Review email service docs in `emailService.ts`
- Test SMTP connection manually
- Contact your email provider's support

## Related Files

- `functions/src/emailService.ts` - Email service implementation
- `functions/src/userManagement.ts` - Auth functions using email service
- `.runtimeconfig.json` - Local development config (git-ignored)
- `package.json` - Includes nodemailer dependency
