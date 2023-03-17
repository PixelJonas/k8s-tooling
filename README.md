# k8s tooling Image

This is my personal Image to be used with [Red Hat DevSpaces](https://developers.redhat.com/products/openshift-dev-spaces/overview). It's based on the [Red Hat Universal Developer Image](quay.io/devspaces/udi-rhel) and installs the following additional tooling

* [Kubeseal](https://github.com/bitnami-labs/sealed-secrets)
* [Hub](https://github.com/github/hub)
* [httpie](https://httpie.io/)
* [k9s](https://k9scli.io/)
* nano
* vim
* zsh
* [My personal dotfiles](https://github.com/PixelJonas/dotfiles.git)

I'ts deployed at [quay.io/jjanz/k8s-tooling](quay.io/jjanz/k8s-tooling)