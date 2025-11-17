/// Energy system configuration constants
class EnergyConfig {
  // Energy costs and limits
  static const int maxEnergy = 100;
  static const int energyPerQuestion = 10;
  static const int energyBonusOnCompletion = 20;

  // Natural refill (calculated on-demand)
  static const int refillRatePerHour = 5;
  static const int refillRateMs = 12 * 60 * 1000; // 12 minutes per energy point

  // Daily bonuses
  static const int dailyLoginBonus = 50;

  // Ad rewards
  static const int adRewardEnergy = 15;
  static const int adCooldownMinutes = 5;
  static const int maxAdsPerDay = 10;

  // Premium subscription benefits
  static const int premiumMaxEnergy = 200;
  static const int premiumRefillRatePerHour = 10;
  static const bool premiumUnlimited = false;
}
