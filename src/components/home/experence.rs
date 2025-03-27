use dioxus::prelude::*;

#[component]
pub fn Experience() -> Element {
    rsx! {
        section { id: "experience",
            h2 { "Experience" }
            p { "Experience details coming soon..." }
        }
    }
}
