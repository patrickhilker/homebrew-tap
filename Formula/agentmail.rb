# Template for Formula/agentmail.rb in patrickhilker/homebrew-tap.
# The release workflow fills in 0.4.1 and 448abe993f3fc31bd9c48b9508192499fe1d069300882a3b438ae8320376f9de and pushes it to the tap.
class Agentmail < Formula
  desc "Email for AI agents on a catch-all IMAP/SMTP mailbox"
  homepage "https://github.com/patrickhilker/agentmail"
  url "https://github.com/patrickhilker/agentmail/releases/download/v0.4.1/agentmail.mjs"
  version "0.4.1"
  sha256 "448abe993f3fc31bd9c48b9508192499fe1d069300882a3b438ae8320376f9de"
  license "MIT"

  depends_on "node"

  def install
    libexec.install "agentmail.mjs"
    (bin/"agentmail").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/agentmail.mjs" "$@"
    SH
  end

  def caveats
    <<~EOS
      Set up the mailbox and the Claude Code skill:
        agentmail config init
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agentmail --version").strip
  end
end
