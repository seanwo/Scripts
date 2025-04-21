#!/bin/bash

if [[ $# -ne 1 ]] ; then
    echo Usage: $0 '<action>'
    echo
    echo action = enable \| disable-user
    exit 1
fi
action="$1"

./adb shell pm "$action" amazon.jackson19                                 # Jackson19
./adb shell pm "$action" amazon.speech.sim                                # Alexa Speech
./adb shell pm "$action" com.amazon.aca                                   # ACA Application
./adb shell pm "$action" com.amazon.advertisingidsettings                 # Advertising ID
./adb shell pm "$action" com.amazon.afe.app                               # Tap to Alexa
./adb shell pm "$action" com.amazon.ags.app                               # Amazon GameCircle
##./adb shell pm "$action" com.amazon.alexa.multimodal.gemini               # Alexa Cards
##./adb shell pm "$action" com.amazon.alexa.youtube.app                     # Alexa YouTube Player
./adb shell pm "$action" com.amazon.alta.h2clientservice                  # H2Application
./adb shell pm "$action" com.amazon.application.compatibility.enforcer    # Application Compatibility Enforcer
./adb shell pm "$action" com.amazon.appverification                       # Amazon App Verification
./adb shell pm "$action" com.amazon.avod                                  # Prime Video
./adb shell pm "$action" com.amazon.bioscope                              # Amazon VideoStore
./adb shell pm "$action" com.amazon.cardinal                              # Alexa Video Player
##./adb shell pm "$action" com.amazon.charles                               # Charles Proxy
##./adb shell pm "$action" com.amazon.client.metrics                        # Amazon Client Metrics
./adb shell pm "$action" com.amazon.client.metrics.api                    # Amazon Client Metrics API
./adb shell pm "$action" com.amazon.cloud9.contentservice                 # Silk Browser Content Service
./adb shell pm "$action" com.amazon.cloud9.kids                           # Kids Web Browser
./adb shell pm "$action" com.amazon.cloud9.systembrowserprovider          # Silk Browser Provider
./adb shell pm "$action" com.amazon.comms.kids                            # Alexa Communication
./adb shell pm "$action" com.amazon.communication.discovery               # Amazon Communication Discovery
./adb shell pm "$action" com.amazon.connectivitydiag                      # Connectivity Diagnostics
##./adb shell pm "$action" com.amazon.csapp                                 # Help App
./adb shell pm "$action" com.amazon.dcp                                   # Amazon Device Middleware Debugging Tool
./adb shell pm "$action" com.amazon.dcp.contracts.framework.library       # DCP Contracts Framework
./adb shell pm "$action" com.amazon.dcp.contracts.library                 # DCP Platform Contracts
./adb shell pm "$action" com.amazon.dcpms.fos.service                     # DCPMSFOSService
##/adb shell pm "$action" com.amazon.dee.alexaonandroidos                  # Alexa on Android OS
./adb shell pm "$action" com.amazon.dee.app                               # Alexa
##./adb shell pm "$action" com.amazon.device.messaging                      # Amazon Device Messaging (ADM)
##./adb shell pm "$action" com.amazon.device.metrics                        # Amazon Device Metrics
./adb shell pm "$action" com.amazon.device.sale.service                   # Amazon Sale Service
##./adb shell pm "$action" com.amazon.device.sync                           # Amazon Sync Service
##./adb shell pm "$action" com.amazon.device.sync.sdk.internal              # Amazon Sync SDK
##./adb shell pm "$action" com.amazon.diode                                 # Diode Apk
./adb shell pm "$action" com.amazon.dp.contacts                           # Amazon Contacts Sync Adapter
./adb shell pm "$action" com.amazon.dp.fbcontacts                         # Facebook Sync Adapter
./adb shell pm "$action" com.amazon.dp.logger                             # Amazon DP Logger
./adb shell pm "$action" com.amazon.dpcclient                             # Amazon DCPCClient Application
./adb shell pm "$action" com.amazon.fireos.cirruscloud                    # Cirrus Cloud
./adb shell pm "$action" com.amazon.firespotlight                         # Amazon Appstore Spotlight
##./adb shell pm "$action" com.amazon.geo.client.maps                       # Amazon Maps App
##./adb shell pm "$action" com.amazon.geo.mapsv2                            # Map API v2
##./adb shell pm "$action" com.amazon.geo.mapsv3.resources                  # Map API v3 Resources
##./adb shell pm "$action" com.amazon.geo.mapsv3.services                   # Map API v3 Services
./adb shell pm "$action" com.amazon.hedwig                                # Fire TV Channels
./adb shell pm "$action" com.amazon.h2settingsfortablet                   # Profile Settings (Amazon Profiles & Family Library)
./adb shell pm "$action" com.amazon.hybridadidservice                     # Hybrid AD ID Service
##./adb shell pm "$action" com.amazon.identity.auth.device.authorization    # Mobile Authentication Platform
./adb shell pm "$action" com.amazon.imdb.tv.mobile.app                    # Freevee (IMDb)
#./adb shell pm "$action" com.amazon.imp                                   # Identity Mobile Platform
##./adb shell pm "$action" com.amazon.iris                                  # News
#./adb shell pm "$action" com.amazon.kindle                                # Kindle
##./adb shell pm "$action" com.amazon.kindle.kso                            # Special Offers
##./adb shell pm "$action" com.amazon.kindle.otter.oobe                     # Device Setup
##./adb shell pm "$action" com.amazon.kindle.personal_video                 # My Videos
./adb shell pm "$action" com.amazon.kindle.rdmdeviceadmin                 # Remote Device Management Application
./adb shell pm "$action" com.amazon.kindle.unifiedSearch                  # Unified Search
./adb shell pm "$action" com.amazon.kor.demo                              # Retail Demo
##./adb shell pm "$action" com.amazon.legalsettings                         # Legal Notices
./adb shell pm "$action" com.amazon.logan                                 # Voice View
./adb shell pm "$action" com.amazon.media.session.monitor                 # Media Session Monitor
##./adb shell pm "$action" com.amazon.minerva.client.api                    # Amazon Minerva Client API
./adb shell pm "$action" com.amazon.mp3                                   # Amazon Music
##./adb shell pm "$action" com.amazon.nimh                                  # Arcus Android Client
./adb shell pm "$action" com.amazon.ods.kindleconnect                     # Mayday Screen Sharing
##./adb shell pm "$action" com.amazon.parentalcontrols                      # Parental Controls
./adb shell pm "$action" com.amazon.photos                                # Amazon Photos
##./adb shell pm "$action" com.amazon.photos.importer                       # Amazon Photos Importer
##./adb shell pm "$action" com.amazon.platform                              # Amazon Metrics Service Application
##./adb shell pm "$action" com.amazon.pm                                    # Parental Monitoring Service
./adb shell pm "$action" com.amazon.providers.contentsupport              # Content Support Manager
##./adb shell pm "$action" com.amazon.readynowcore                          # On Deck
./adb shell pm "$action" com.amazon.recess                                # Amazon Recess
##./adb shell pm "$action" com.amazon.securitysyncclient                    # Security Sync Client
./adb shell pm "$action" com.amazon.shpm                                  # Ship Mode
##./adb shell pm "$action" com.amazon.smartgenie                            # Alexa Device Dashboard
./adb shell pm "$action" com.amazon.speakscreen                           # Speak Selection
./adb shell pm "$action" com.amazon.sync.provider.ipc                     # Sync Provider Executor
##./adb shell pm "$action" com.amazon.sync.service                          # Amazon Sync Service
./adb shell pm "$action" com.amazon.tahoe                                 # Amazon Kids+ (Kids Space)
##./adb shell pm "$action" com.amazon.tcomm                                 # Amazon Communication Services
##./adb shell pm "$action" com.amazon.tcomm.client                          # Amazon Communication Services Client Library
./adb shell pm "$action" com.amazon.tcomm.jackson                         # Amazon Communication Service (Jackson19)
##./adb shell pm "$action" com.amazon.tv.launcher                           # Amazon VideoStore
./adb shell pm "$action" com.amazon.tv.ottssocompanionapp                 # OttSsoCompanionApp
##./adb shell pm "$action" com.amazon.venezia                               # Amazon Appstore
./adb shell pm "$action" com.amazon.wallpaper                             # Amazon Wallpaper
./adb shell pm "$action" com.amazon.weather                               # Weather
./adb shell pm "$action" com.amazon.webapp                                # Kindle Store
##./adb shell pm "$action" com.amazon.whisperlink.core.android              # Whisperplay Daemon
./adb shell pm "$action" com.amazon.whisperplay.contracts                 # Whisperlink SDK
##./adb shell pm "$action" com.amazon.whisperplay.service.install           # Whisperlink Installer
./adb shell pm "$action" com.amazon.windowshop                            # Amazon App
./adb shell pm "$action" com.amazon.wirelessmetrics.service               # Amazon Wireless Metrics Service
##./adb shell pm "$action" com.amazon.zico                                  # Documents
./adb shell pm "$action" com.android.bookmarkprovider                     # Bookmarks Provider
./adb shell pm "$action" com.android.carrierconfig                        # Carrier Network Configuration
##./adb shell pm "$action" com.android.dreams.basic                         # Screensaver
./adb shell pm "$action" com.android.email                                # AOSP Mail
./adb shell pm "$action" com.android.protips                              # Home Screen Tips
./adb shell pm "$action" com.android.providers.downloads.ui               # Downloads App
##./adb shell pm "$action" com.android.providers.partnerbookmarks           # Provider Bookmarks
./adb shell pm "$action" com.android.quicksearchbox                       # Search
./adb shell pm "$action" com.audible.application.kindle                   # Audible
##./adb shell pm "$action" com.fireos.arcus.proxy                           # Arcus Proxy
##./adb shell pm "$action" com.fireos.usagestats.proxy                      # Amazon Usage Stats Map Proxy
##./adb shell pm "$action" com.goodreads.kindle                             # Goodreads
./adb shell pm "$action" com.here.odnp.service                            # HERE Positioning
./adb shell pm "$action" com.kingsoft.office.amz                          # WPS Office for Amazon
./adb shell pm "$action" com.android.calendar
./adb shell pm "$action" com.android.contacts
./adb shell settings put secure limit_ad_tracking 1
./adb shell settings put secure usage_metrics_marketing_enabled 0
./adb shell settings put secure USAGE_METRICS_UPLOAD_ENABLED 0
./adb shell settings put global LOCKSCREEN_AD_ENABLED 0
./adb shell settings put secure search_on_lockscreen_settings 0
./adb shell settings put global window_animation_scale 0.50
./adb shell settings put global transition_animation_scale 0.50
./adb shell settings put global animator_duration_scale 0.50