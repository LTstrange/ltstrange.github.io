use dioxus::prelude::*;

mod about;
mod blogs;
mod contact;
mod experence;
mod games;
mod projects;

use about::*;
use blogs::*;
use contact::*;
use experence::*;
use games::*;
use projects::*;

const HERO_IMAGE: Asset = asset!("/assets/hero/heroImage.svg");

#[component]
pub fn Home() -> Element {
    rsx! {
        Nav {}
        Hero {}
        About {}
        Projects {}
        Games {}
        Blogs {}
        Experience {}
        Contact {}
    }
}

#[component]
fn Nav() -> Element {
    rsx! {
        nav {
            a { class: "logo", href: "#nav", "LTstrange" }
            ul {
                li {
                    a { href: "#about", "About" }
                }
                li {
                    a { href: "#projects", "Projects" }
                }
                li {
                    a { href: "#games", "Games" }
                }
                li {
                    a { href: "#blogs", "Blogs" }
                }

                li {
                    a { href: "#experience", "Experience" }
                }
                li {
                    a { href: "#contact", "Contact" }
                }
            }
        }
    }
}

#[component]
fn Hero() -> Element {
    rsx! {
        section { class: "hero", id: "nav",
            div { class: "content",
                h4 { "Hi, I'm" }
                h1 { "LTstrange!" }
                p {
                    "I'm a graduate student at the School of Computer Science, Shenyang Aerospace University. Reach out if you'd like to learn more!"
                }
                a {
                    class: "contact-link",
                    href: "mailto:ltstrange_swh@qq.com",
                    "Contact Me"
                }
            }
            img { class: "hero-image", src: HERO_IMAGE }
        }
    }
}

#[component]
fn Test() -> Element {
    rsx! {
        style {}
    }
}
