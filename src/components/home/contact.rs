use dioxus::prelude::*;

#[component]
pub fn Contact() -> Element {
    rsx! {
        section { id: "contact", class: "contact",
            h2 { "Contact" }
            p { "Feel free to reach out!" }
            div { class: "contact-links",
                a {
                    href: "mailto:ltstrange_swh@qq.com",
                    class: "contact-link",
                    i { class: "fas fa-envelope contact-icon" }
                    span { "ltstrange_swh@qq.com" }
                }
                a {
                    href: "https://github.com/ltstrange",
                    class: "contact-link",
                    target: "_blank",
                    i { class: "fab fa-github contact-icon" }
                    span { "github.com/LTstrange" }
                }
            }
        }
    }
}
