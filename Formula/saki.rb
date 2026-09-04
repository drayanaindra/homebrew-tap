class Saki < Formula
  desc "Backend service for the saki build orchestrator"
  homepage "https://github.com/drayanaindra/saki-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.5.0/saki-backend-darwin-arm64"
      sha256 "822d20bf05dde41a0a503ac284820d2e84242baf0ab5db6a6528c62cec6e7eed"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.5.0/saki-backend-darwin-amd64"
      sha256 "4cb7bbf4c019874f6232623015afb95f4889031095f0ee6df5d55c59d16c2706"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.5.0/saki-backend-linux-arm64"
      sha256 "692715bde0492ad99532d767308b3c2631b1a028e515667ea8eba5b7fff4fee0"
    else
      url "https://github.com/drayanaindra/saki-cli/releases/download/v0.5.0/saki-backend-linux-amd64"
      sha256 "d57112c091be7506b0d507a3d574f7cdb58e9933d3bd9c0599052588fa257d3f"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "saki-backend-darwin-arm64" : "saki-backend-darwin-amd64"
    else
      Hardware::CPU.arm? ? "saki-backend-linux-arm64" : "saki-backend-linux-amd64"
    end
    bin.install binary_name => "saki-backend"
  end

  service do
    run [opt_bin/"saki-backend"]
    keep_alive true
    log_path var/"log/saki-backend.log"
    error_log_path var/"log/saki-backend.log"
  end

  test do
    assert_path_exists bin/"saki-backend"
    assert_predicate bin/"saki-backend", :executable?
  end
end
