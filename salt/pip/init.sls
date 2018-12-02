{% from "pip/map.jinja" import pip with context %}

pip_pkg_installed:
  pkg.installed:
    - name: {{ pip.pip_pkg }}

pip-package_updated:
  pip.installed:
    - name: pip==18.0
