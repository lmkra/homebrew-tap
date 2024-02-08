class HgEvolve < Formula
  include Language::Python::Virtualenv

  desc "Mercurial extension for faster and safer mutable history"
  homepage "https://www.mercurial-scm.org/doc/evolution/user-guide.html"
  license "GPL-2.0-or-later"

  stable do
    url "https://files.pythonhosted.org/packages/b9/d0/03b4019d3e554a47efaeb43171a15a0cde8e117e73cbf8cbd7e5ce06b130/hg-evolve-11.1.1.tar.gz"
    sha256 "1c564dfc92503e5541e7bc5c514c725ebac3e04a8f83dbd809101ae0f0101e8c"

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
