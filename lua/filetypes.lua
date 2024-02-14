local M = {}

M.groovy = { "Jenkinsfile", "Jenkinsfile.mep", "Jenkinsfile.rollback", "*.jenkinsfile" }
M.yaml = { "*.yaml.tmpl", "*.yaml.tpl" }
M.dockerfile = { "*.dockerfile" }
M.starlark = { "Tiltfile" }

return M
