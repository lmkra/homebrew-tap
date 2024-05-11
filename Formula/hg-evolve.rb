class HgEvolve < Formula
  include Language::Python::Virtualenv

  desc "Mercurial extension for faster and safer mutable history"
  homepage "https://www.mercurial-scm.org/doc/evolution/user-guide.html"
  license "GPL-2.0-or-later"

  stable do
    url "https://files.pythonhosted.org/packages/94/f7/f3781a1d9a0128ca8a69351db1f3a10dedf96a0838f5daecb90ed1b69fd7/hg-evolve-11.1.3.tar.gz"
    sha256 "5943cea24feda59252a2893308810744a0254f3799e91258d0889c9604143acf"

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
