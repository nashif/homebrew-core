class DockerMachineDriverVultr < Formula
  desc "Docker Machine driver plugin for Vultr Cloud"
  homepage "https://github.com/janeczku/docker-machine-vultr"
  url "https://github.com/janeczku/docker-machine-vultr/archive/v1.4.0.tar.gz"
  sha256 "f69b1b33c7c73bea4ab1980fbf59b7ba546221d31229d03749edee24a1e7e8b5"

  head "https://github.com/janeczku/docker-machine-vultr.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "cc40df5eccd1516540fe956a32b133db425998802ed6c7d7d813c888ceef5b83" => :high_sierra
    sha256 "391f3c42b495f904e4ee2ae48fe6075fe8198b6041c547a16f24c60bebfbabdb" => :sierra
    sha256 "4754852f855f0c6e0c188cc23614bc8b83e5da4398de211b1124775095b80aa3" => :el_capitan
    sha256 "af713bea18525c72510362c0765bcab4131badd9baa49bbad6628432016d92dd" => :yosemite
  end

  depends_on "go" => :build
  depends_on "godep" => :build
  depends_on "docker-machine" => :recommended

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/janeczku/docker-machine-vultr").install buildpath.children

    cd "src/github.com/janeczku/docker-machine-vultr" do
      system "make"
      bin.install "build/docker-machine-driver-vultr-v#{version}" => "docker-machine-driver-vultr"
    end
  end

  test do
    assert_match "--vultr-api-endpoint",
      shell_output("#{Formula["docker-machine"].bin}/docker-machine create --driver vultr -h")
  end
end
