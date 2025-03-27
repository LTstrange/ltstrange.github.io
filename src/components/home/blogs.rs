use dioxus::prelude::*;

#[component]
pub fn Blogs() -> Element {
    rsx! {
        section { id: "blogs",
            h2 { "Blogs" }
            p { "Blog content coming soon... " }
        }
    }
}
