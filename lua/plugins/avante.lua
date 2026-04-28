require('avante').setup({
    provider = "groq",
    auto_suggestions_provider = "groq",
    behaviour = {
        auto_suggestions = true,
        auto_suggestions_respect_ignore = true,
    },
    providers = {
        groq = {
            __inherited_from = "openai",
            api_key_name = "GROQ_API_KEY",
            endpoint = "https://api.groq.com/openai/v1/",
            model = "moonshotai/kimi-k2-instruct-0905",
        },
    },
    suggestion = {
        debounce = 600,
        throttle = 600,
    },
})
