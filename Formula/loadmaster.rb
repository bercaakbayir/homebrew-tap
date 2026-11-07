class Loadmaster < Formula
  desc "Weight, balance and preflight for local LLMs: will it fit, how to launch it, does it actually emit tool calls"
  homepage "https://github.com/bercaakbayir/loadmaster"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bercaakbayir/loadmaster/releases/download/v0.3.0/loadmaster-aarch64-apple-darwin.tar.xz"
      sha256 "778887b391bba6e096a71ff92db06b58d42ac1d990957a61500265c5af2976df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bercaakbayir/loadmaster/releases/download/v0.3.0/loadmaster-x86_64-apple-darwin.tar.xz"
      sha256 "fa3b5e072c26fede448b1de52753779a7d965166c62ca87f65d556ab1b5b4db5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bercaakbayir/loadmaster/releases/download/v0.3.0/loadmaster-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "45534e3b48a75ac9eb85ca5303bf7b3b60bc47b5afe27fbf80e123802d483dcb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bercaakbayir/loadmaster/releases/download/v0.3.0/loadmaster-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8324a93276c97c0e625ab52093f71fe0533cf5752ce6f1e7f1e0123fdea0b3bc"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "lm", "loadmaster"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lm", "loadmaster"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lm", "loadmaster"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lm", "loadmaster"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
