# Template for Formula/agentmail.rb in patrickhilker/homebrew-tap.
# The release workflow fills in 0.4.0 and c9b8ef90663e9b0bec7e42e305bb6bfec72c1f2fcbc4828f0bdcf9fea86f372b and pushes it to the tap.
class Agentmail < Formula
  desc "Email for AI agents on a catch-all IMAP/SMTP mailbox"
  homepage "https://github.com/patrickhilker/agentmail"
  url "https://github.com/patrickhilker/agentmail/releases/download/v0.4.0/agentmail.mjs"
  version "0.4.0"
  sha256 "c9b8ef90663e9b0bec7e42e305bb6bfec72c1f2fcbc4828f0bdcf9fea86f372b"

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
