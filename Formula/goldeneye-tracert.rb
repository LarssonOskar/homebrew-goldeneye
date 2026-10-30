class GoldeneyeTracert < Formula
  desc "Traceroute visualized as a GoldenEye satellite uplink terminal"
  homepage "https://github.com/LarssonOskar/goldeneye-tracert"
  url "https://github.com/LarssonOskar/goldeneye-tracert/releases/download/v0.7.3/goldeneye-tracert-0.7.3.tar.gz"
  sha256 "415cfcda59e19783bc835451c84abaac18da30bd514a2761eeffc1667ed4ccfd"
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
    assert_match "goldeneye-tracert 0.7.3",
                 shell_output("#{bin}/goldeneye-tracert --version")
    assert_match "GOLDENEYE",
                 shell_output("#{bin}/goldeneye-tracert --demo --once --no-color --width 80 --height 24")
  end
end
