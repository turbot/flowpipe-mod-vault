mod "vault" {
  title         = "Hashicorp Vault"
  description   = "Run pipelines to supercharge your Vault workflows using Flowpipe."
  color         = "#003A75"
  documentation = file("./README.md")
  icon          = "/images/mods/turbot/vault.svg"
  categories    = ["library", "access management"]

  opengraph {
    title       = "Hashicorp Vault Mod for Flowpipe"
    description = "Run pipelines to supercharge your Vault workflows using Flowpipe."
    image       = "/images/mods/turbot/vault-social-graphic.png"
  }

  require {
    flowpipe {
      min_version = "1.0.0"
    }
  }
}
