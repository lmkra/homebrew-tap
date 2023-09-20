class HgEvolve < Formula
  include Language::Python::Virtualenv

  desc "Mercurial extension for faster and safer mutable history"
  homepage "https://www.mercurial-scm.org/doc/evolution/user-guide.html"
  license "GPL-2.0-or-later"

  stable do
    url "https://files.pythonhosted.org/packages/7d/0e/608b134a204d9e5f7f33668acde5d565ad65ef2eecca64226a9426d1600f/hg-evolve-11.0.2.tar.gz"
    sha256 "a8351115c0e6ef3bc312fd59f9aa17b457db8a5ba5eaae8a9648c1be191e6243"
  end

  livecheck do
    url :stable
    strategy :pypi
  end

  bottle do
    sha256 cellar: :any_skip_relocation, monterey: "a0c9ec9732f158772fa980ca6527682b56769324decbf9f22ea13d4e5e1dbb44"
  end

  head do
    # Nothing to do
  end

  depends_on "mercurial"
  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources

    site_packages = Language::Python.site_packages("python3.11")
    (prefix/site_packages/"homebrew-#{@name}.pth").write libexec/site_packages
  end

  test do
    (testpath/".hgrc").write <<~EOS
      [extensions]
      evolve =
    EOS
    system "hg", "help", "evolve", "--pager=none"
  end
end
