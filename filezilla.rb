cask 'filezilla' do
  version ''
  sha256 :no_check

  url "https://download.filezilla-project.org/client/FileZilla_#{version}_macos-arm64.app.tar.bz2"
  name 'FileZilla'
  homepage 'https://filezilla-project.org/'

  app 'FileZilla.app'

  zap trash: [
               '~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/de.filezilla.sfl*',
               '~/Library/Saved Application State/org.filezilla-project.filezilla.savedState',
               '~/Library/Preferences/org.filezilla-project.filezilla.plist',
               '~/.config/filezilla',
             ]
end
