/**
 * Email Service for Path of Light
 * Handles email sending using Nodemailer
 */

import * as nodemailer from "nodemailer";
import * as functions from "firebase-functions";

/**
 * Email configuration interface
 */
interface EmailConfig {
  host: string;
  port: number;
  secure: boolean;
  auth: {
    user: string;
    pass: string;
  };
}

/**
 * Email options interface
 */
interface EmailOptions {
  to: string;
  subject: string;
  html: string;
  text?: string;
}

/**
 * Get email transporter based on environment configuration
 * Configuration should be set in Firebase Functions config or environment variables
 */
function getEmailTransporter() {
  // Try to get config from Firebase Functions config
  const emailConfig = functions.config().email;

  if (!emailConfig) {
    console.warn(
      "Email configuration not found. " +
      "Set using: firebase functions:config:set email.host=... email.port=... email.user=... email.pass=..."
    );
    // Return null transporter for development - emails won't be sent
    return null;
  }

  const config: EmailConfig = {
    host: emailConfig.host || "smtp.gmail.com",
    port: parseInt(emailConfig.port || "587"),
    secure: emailConfig.secure === "true",
    auth: {
      user: emailConfig.user,
      pass: emailConfig.pass,
    },
  };

  return nodemailer.createTransport(config);
}

/**
 * Send email using configured transporter
 */
export async function sendEmail(options: EmailOptions): Promise<boolean> {
  const transporter = getEmailTransporter();

  if (!transporter) {
    console.log(
      "Email would be sent (no transporter configured):\n",
      `To: ${options.to}\n`,
      `Subject: ${options.subject}\n`,
      `HTML:\n${options.html}\n`,
      `Text:\n${options.text || "N/A"}`
    );
    return false;
  }

  try {
    const emailConfig = functions.config().email;
    const fromEmail = emailConfig.from || emailConfig.user;
    const fromName = emailConfig.from_name || "Path of Light";

    const mailOptions = {
      from: `${fromName} <${fromEmail}>`,
      to: options.to,
      subject: options.subject,
      html: options.html,
      text: options.text || options.html.replace(/<[^>]*>/g, ""), // Strip HTML for text version
    };

    const result = await transporter.sendMail(mailOptions);
    console.log("Email sent successfully:", result.messageId);
    return true;
  } catch (error) {
    console.error("Error sending email:", error);
    throw new Error(`Failed to send email: ${error}`);
  }
}

/**
 * Send email verification email
 */
export async function sendVerificationEmail(
  email: string,
  verificationLink: string,
  displayName?: string
): Promise<boolean> {
  const name = displayName || "User";

  const html = getEmailVerificationTemplate(name, verificationLink);
  const text = `
Hello ${name},

Welcome to Path of Light!

Please verify your email address by clicking the link below:

${verificationLink}

This link will expire in 24 hours.

If you didn't create an account with Path of Light, please ignore this email.

Best regards,
Path of Light Team
  `.trim();

  return sendEmail({
    to: email,
    subject: "Verify Your Email - Path of Light",
    html,
    text,
  });
}

/**
 * Send password reset email
 */
export async function sendPasswordResetEmail(
  email: string,
  resetLink: string
): Promise<boolean> {
  const html = getPasswordResetTemplate(resetLink);
  const text = `
Hello,

We received a request to reset your password for your Path of Light account.

Click the link below to reset your password:

${resetLink}

This link will expire in 1 hour.

If you didn't request a password reset, please ignore this email or contact support if you have concerns.

Best regards,
Path of Light Team
  `.trim();

  return sendEmail({
    to: email,
    subject: "Reset Your Password - Path of Light",
    html,
    text,
  });
}

/**
 * Get email verification HTML template
 */
function getEmailVerificationTemplate(
  name: string,
  verificationLink: string
): string {
  return `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Verify Your Email</title>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
      line-height: 1.6;
      color: #333;
      max-width: 600px;
      margin: 0 auto;
      padding: 20px;
      background-color: #f4f4f4;
    }
    .container {
      background-color: #ffffff;
      border-radius: 8px;
      padding: 40px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .header {
      text-align: center;
      margin-bottom: 30px;
    }
    .header h1 {
      color: #2c5aa0;
      margin: 0;
      font-size: 28px;
    }
    .content {
      margin-bottom: 30px;
    }
    .button {
      display: inline-block;
      padding: 14px 32px;
      background-color: #2c5aa0;
      color: #ffffff !important;
      text-decoration: none;
      border-radius: 6px;
      font-weight: 600;
      text-align: center;
      margin: 20px 0;
    }
    .button:hover {
      background-color: #234a82;
    }
    .footer {
      text-align: center;
      margin-top: 30px;
      padding-top: 20px;
      border-top: 1px solid #e0e0e0;
      font-size: 14px;
      color: #666;
    }
    .link {
      color: #2c5aa0;
      word-break: break-all;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Path of Light</h1>
    </div>
    <div class="content">
      <h2>Hello ${name},</h2>
      <p>Welcome to Path of Light! We're excited to have you on your spiritual journey.</p>
      <p>Please verify your email address by clicking the button below:</p>
      <center>
        <a href="${verificationLink}" class="button">Verify Email Address</a>
      </center>
      <p>Or copy and paste this link into your browser:</p>
      <p class="link">${verificationLink}</p>
      <p><strong>Note:</strong> This link will expire in 24 hours.</p>
      <p>If you didn't create an account with Path of Light, please ignore this email.</p>
    </div>
    <div class="footer">
      <p>Best regards,<br>The Path of Light Team</p>
      <p>This is an automated email. Please do not reply.</p>
    </div>
  </div>
</body>
</html>
  `.trim();
}

/**
 * Get password reset HTML template
 */
function getPasswordResetTemplate(resetLink: string): string {
  return `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reset Your Password</title>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
      line-height: 1.6;
      color: #333;
      max-width: 600px;
      margin: 0 auto;
      padding: 20px;
      background-color: #f4f4f4;
    }
    .container {
      background-color: #ffffff;
      border-radius: 8px;
      padding: 40px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .header {
      text-align: center;
      margin-bottom: 30px;
    }
    .header h1 {
      color: #2c5aa0;
      margin: 0;
      font-size: 28px;
    }
    .content {
      margin-bottom: 30px;
    }
    .button {
      display: inline-block;
      padding: 14px 32px;
      background-color: #2c5aa0;
      color: #ffffff !important;
      text-decoration: none;
      border-radius: 6px;
      font-weight: 600;
      text-align: center;
      margin: 20px 0;
    }
    .button:hover {
      background-color: #234a82;
    }
    .footer {
      text-align: center;
      margin-top: 30px;
      padding-top: 20px;
      border-top: 1px solid #e0e0e0;
      font-size: 14px;
      color: #666;
    }
    .link {
      color: #2c5aa0;
      word-break: break-all;
    }
    .warning {
      background-color: #fff3cd;
      border-left: 4px solid #ffc107;
      padding: 12px;
      margin: 20px 0;
      border-radius: 4px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Path of Light</h1>
    </div>
    <div class="content">
      <h2>Password Reset Request</h2>
      <p>We received a request to reset your password for your Path of Light account.</p>
      <p>Click the button below to reset your password:</p>
      <center>
        <a href="${resetLink}" class="button">Reset Password</a>
      </center>
      <p>Or copy and paste this link into your browser:</p>
      <p class="link">${resetLink}</p>
      <div class="warning">
        <strong>⚠️ Security Notice:</strong> This link will expire in 1 hour for your security.
      </div>
      <p>If you didn't request a password reset, please ignore this email or contact our support team if you have concerns about your account security.</p>
    </div>
    <div class="footer">
      <p>Best regards,<br>The Path of Light Team</p>
      <p>This is an automated email. Please do not reply.</p>
    </div>
  </div>
</body>
</html>
  `.trim();
}
