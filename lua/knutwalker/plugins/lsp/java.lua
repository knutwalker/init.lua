local M = {}

function M.setup(lsp_opts)
    if M.cached_opts then
        return
    end

    local java_installs = os.getenv("HOME") .. "/.local/share/mise/installs/java/"
    local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local data_dir = vim.fn.stdpath("data") .. "/jdtls/data/" .. project_name
    local project_dir = vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })
    local root_dir = #project_dir > 0 and project_dir[1] or vim.fn.getcwd()

    local jdt_opts = {
        cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xms1g",
            "-Xmx8g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens=java.base/java.util=ALL-UNNAMED",
            "--add-opens=java.base/java.lang=ALL-UNNAMED",
            "--add-opens=java.base/java.lang.invoke=ALL-UNNAMED",
            "--add-opens=java.base/java.io=ALL-UNNAMED",
            "--add-opens=java.base/java.nio=ALL-UNNAMED",
            "--add-opens=java.base/java.util.stream=ALL-UNNAMED",
            "--add-opens=java.base/sun.net.www.protocol.http=ALL-UNNAMED",
            "--add-opens=java.base/sun.nio.ch=ALL-UNNAMED",
            "--add-opens=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED",
            "-jar",
            jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
            "-configuration",
            jdtls_path .. "/config_mac",
            "-data",
            data_dir,
        },

        root_dir = root_dir,

        settings = {
            java = {
                codeGeneration = {
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    useBlocks = true,
                    hashCodeEquals = "useJava7Objects",
                },
                completion = {
                    favoriteStaticMembers = {
                        "org.assertj.core.api.Assertions.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                    },
                },
                configuration = {
                    runtimes = {
                        {
                            name = "JavaSE-17",
                            path = java_installs .. "/temurin-17/",
                        },
                        {
                            name = "JavaSE-21",
                            path = java_installs .. "/temurin-21/",
                        },
                        {
                            name = "JavaSE-23",
                            path = java_installs .. "/temurin-23/",
                        },
                    },
                },
                contentProvider = { preferred = "fernflower" },
                implementationsCodeLens = { enabled = true },
                import = {
                    gradle = {
                        enabled = true,
                        wrapper = {
                            enabled = true,
                        },
                        annotationProcessing = {
                            enabled = true,
                        },
                    },
                    maven = {
                        enabled = false,
                    },
                },
                inlayHints = {
                    parameterNames = { enabled = true },
                },
                referenceCodeLens = { enabled = true },
                references = {
                    includeAccessors = true,
                    includeDecompiledSources = true,
                },
                rename = { enabled = true },
                saveActions = {
                    organizeImports = true,
                },
                signatureHelp = { enabled = true },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
            },
        },
    }

    local opts = vim.tbl_deep_extend("keep", jdt_opts, lsp_opts)

    M.cached_opts = opts
end

function M.attach(bind)
    local jdtls = require("jdtls")

    bind("<leader>Jo", jdtls.organize_imports, "[J]ava [O]rganize imports")
    bind("<leader>Jtc", jdtls.test_class, "[J]ava [T]est [C]lass")
    bind("<leader>Jtm", jdtls.test_nearest_method, "[J]ava [T]est [M]ethod")
    bind("<leader>Jv", jdtls.extract_variable, "[J]ava Extract [V]ariable")
    bind("<leader>Jc", jdtls.extract_constant, "[J]ava Extract [C]onstant")
    bind("<leader>Jv", function()
        jdtls.extract_variable(true)
    end, "[J]ava Extract [V]ariable", "x")
    bind("<leader>Jc", function()
        jdtls.extract_constant(true)
    end, "[J]ava Extract [C]onstant", "x")
    bind("<leader>Jm", function()
        jdtls.extract_method(true)
    end, "[J]ava Extract [M]ethod", "x")
    bind("<leader>JD", function()
        require("jdtls.dap").setup_dap_main_class_configs()
    end, "[J]ava [D]ebugger")

    jdtls.setup_dap({ hotcodereplace = "auto" })
end

return M
