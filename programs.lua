local programs = {
  {
    name = "Infusion Control",
    description = "Program for automating crafts on runic matrix from thaumcraft",
    repository = "Navatusein/GTNH-OC-Infusion-Control",
    archiveName = "InfusionControl",
    lastSupportedGtnhVersion = "2.8",
    versions = {
      {
        gtnhVersion = "2.8",
        configDescriptorUrl = "https://raw.githubusercontent.com/Navatusein/GTNH-OC-Infusion-Control/main/config-descriptor.yml"
      }
    }
  },
  {
    name = "LSC Control",
    description = "Program for managing a battery, generators connected to it and large energy consumers",
    repository = "Navatusein/GTNH-OC-LSC-Control",
    archiveName = "LSCControl",
    versions = {
      {
        gtnhVersion = "2.8",
        configDescriptorUrl = "https://raw.githubusercontent.com/Navatusein/GTNH-OC-LSC-Control/main/config-descriptor.yml"
      }
    }
  },
  {
    name = "Water Line Control",
    description = "Program for the automation of Grate water production from t3 to t8",
    repository = "Navatusein/GTNH-OC-Water-Line-Control",
    archiveName = "WaterLineControl",
    versions = {
      {
        gtnhVersion = "2.8",
        configDescriptorUrl = "https://raw.githubusercontent.com/Navatusein/GTNH-OC-Water-Line-Control/main/config-descriptor.yml"
      }
    }
  },
  {
    name = "Teleposer Control",
    description = "Program to automate the shifting of Teleposition Focus to Teleposer from Blood Magic",
    repository = "Navatusein/GTNH-OC-Teleposer-Control",
    archiveName = "TeleposerControl",
    versions = {
      {
        gtnhVersion = "2.8",
        configDescriptorUrl = "https://raw.githubusercontent.com/Navatusein/GTNH-OC-Teleposer-Control/main/config-descriptor.yml"
      }
    }
  },
  {
    name = "God Forge Control",
    description = "Program for automating the production of Degenerate Quark Gluon Plasma and Molten Magmatter",
    repository = "Navatusein/GTNH-OC-God-Forge-Control",
    archiveName = "GodForgeControl",
    versions = {
      {
        gtnhVersion = "2.8",
        configDescriptorUrl = "https://raw.githubusercontent.com/Navatusein/GTNH-OC-God-Forge-Control/main/config-descriptor.yml",
        tag = "v1.0.6"
      },
      {
        gtnhVersion = "2.9+",
        configDescriptorUrl = "https://raw.githubusercontent.com/Navatusein/GTNH-OC-God-Forge-Control/main/config-descriptor.yml",
        tag = "v2.0.0-dev.2"
      }
    }
  },
  {
    name = "Black Hole Control",
    description = "Program for automating crafting in the Pseudostable Black Hole Containment Field",
    repository = "Navatusein/GTNH-OC-Black-Hole-Control",
    archiveName = "BlackHoleControl",
    versions = {
      {
        gtnhVersion = "2.8",
        configDescriptorUrl = "https://raw.githubusercontent.com/Navatusein/GTNH-OC-Black-Hole-Control/main/config-descriptor.yml"
      }
    }
  },
}

return programs
