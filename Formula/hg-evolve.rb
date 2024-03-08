class HgEvolve < Formula
  include Language::Python::Virtualenv

  desc "Mercurial extension for faster and safer mutable history"
  homepage "https://www.mercurial-scm.org/doc/evolution/user-guide.html"
  license "GPL-2.0-or-later"

  stable do
    url "https://files.pythonhosted.org/packages/82/f0/371e61f225f192a71336c961d1241f050cea6221b13715007fe1b381fa5c/hg-evolve-11.1.2.tar.gz"
    sha256 "ba0f93d6c45207e279172ab375347bc59b6fc9b85dcc165823b838ad7d780c7a"

    depends_on "mercurial"
    depends_on "python@3.12"
  end

  livecheck do
    url :stable
    strategy :pypi
  end

  head do
    # Nothing to do
  end

  def install
    virtualenv_install_with_resources

    site_packages = Language::Python.site_packages("python3.12")
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
