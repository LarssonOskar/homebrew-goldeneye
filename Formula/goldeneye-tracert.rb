class GoldeneyeTracert < Formula
  desc "Traceroute visualized as a GoldenEye satellite uplink terminal"
  homepage "https://github.com/LarssonOskar/goldeneye-tracert"
  url "https://github.com/LarssonOskar/goldeneye-tracert/releases/download/v0.6.1/goldeneye-tracert-0.6.1.tar.gz"
  sha256 "0225b97fb4c0c45e80249c4e590d4b00ae0a9aa4bac0133fe3d5aeb837ee5a2a"
  license "MIT"
  head "https://github.com/LarssonOskar/goldeneye-tracert.git", branch: "main"

  depends_on "node"

  def install
    # package.json is required so Node treats the .ts files as ESM.
    libexec.install "src", "package.json"

    (bin/"goldeneye-tracert").write <<~SH
      #!/bin/sh
      exec "#{formula_opt_bin("node")}/node" "#{libexec}/src/cli.ts" "$@"
    SH
    chmod 0755, bin/"goldeneye-tracert"
  end

  def caveats
    return unless OS.linux?

    <<~EOS
      goldeneye-tracert requires traceroute on Linux. Install it with your
      distribution's package manager, for example:
        sudo apt install traceroute
    EOS
  end

  test do
    assert_match "goldeneye-tracert 0.6.1",
                 shell_output("#{bin}/goldeneye-tracert --version")
    assert_match "GOLDENEYE",
                 shell_output("#{bin}/goldeneye-tracert --demo --once --no-color --width 80 --height 24")
  end
end
