#!/bin/bash

DOMAIN="com.brave.Browser"

defaults write "$DOMAIN" BraveAIChatEnabled -bool false
defaults write "$DOMAIN" BraveNewsDisabled -bool true
defaults write "$DOMAIN" BraveP3AEnabled -bool false
defaults write "$DOMAIN" BraveRewardsDisabled -bool true
defaults write "$DOMAIN" BraveStatsPingEnabled -bool false
defaults write "$DOMAIN" BraveTalkDisabled -bool true
defaults write "$DOMAIN" BraveVPNDisabled -bool true
defaults write "$DOMAIN" BraveWebDiscoveryEnabled -bool false

defaults write "$DOMAIN" DefaultBrowserSettingEnabled -bool false
defaults write "$DOMAIN" FeedbackSurveysEnabled -bool false
defaults write "$DOMAIN" MediaRecommendationsEnabled -bool false
defaults write "$DOMAIN" MetricsReportingEnabled -bool false
defaults write "$DOMAIN" PasswordManagerEnabled -bool false
defaults write "$DOMAIN" PromotionsEnabled -bool false
defaults write "$DOMAIN" SafeBrowsingExtendedReportingEnabled -bool false
defaults write "$DOMAIN" ShoppingListEnabled -bool false
defaults write "$DOMAIN" TorDisabled -bool true
defaults write "$DOMAIN" UrlKeyedAnonymizedDataCollectionEnabled -bool false

killall cfprefsd 2>/dev/null
killall "Brave Browser" 2>/dev/null
