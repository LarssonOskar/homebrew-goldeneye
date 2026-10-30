class GoldeneyeTracert < Formula
  desc "Traceroute visualized as a GoldenEye satellite uplink terminal"
  homepage "https://github.com/LarssonOskar/goldeneye-tracert"
  url "https://github.com/LarssonOskar/goldeneye-tracert/releases/download/v0.7.4/goldeneye-tracert-0.7.4.tar.gz"
  sha256 "cc78a662d5fb85188f4dfd7a6b124d7dd8154544a8cae0f834862c1078629dac"
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
    assert_match "goldeneye-tracert 0.7.4",
                 shell_output("#{bin}/goldeneye-tracert --version")
    assert_match "GOLDENEYE",
                 shell_output("#{bin}/goldeneye-tracert --demo --once --no-color --width 80 --height 24")
  end
end
