use dioxus::prelude::*;

#[component]
pub fn About() -> Element {
    rsx! {
        section { id: "about", class: "about",
            h2 { "About" }
            p { "Here's a brief introduction about myself and my skills." }
            div { class: "about-content",
                div { class: "about-text",
                    img {
                        class: "about-image",
                        src: asset!("/assets/about/aboutImage.png"),
                    }
                    div { class: "roles",
                        RoleCard { class_name: "code", title: "Programmer",
                            "I'm a skilled programmer proficient in Python, C#, and Rust, with a passion for creating complex but intriguing projects."
                        }

                        RoleCard { class_name: "brain", title: "AI Engineer",
                            "I'm an AI engineer specializing in deep learning, developing intelligent systems to solve complex problems."
                        }

                        RoleCard { class_name: "gamepad", title: "Game Maker",
                            "I'm an indie game developer, using Godot and Bevy to build creative and engaging gaming experiences."
                        }
                    }
                }
                div { class: "skills",
                    h3 { "Skills & Technologies" }
                    div { class: "skill-grid",
                        SkillItem {
                            img: asset!("/assets/skills/CSharp.svg"),
                            text: "C#",
                        }
                        SkillItem {
                            img: asset!("/assets/skills/Python.svg"),
                            text: "Python",
                        }
                        SkillItem {
                            img: asset!("/assets/skills/Rust.svg"),
                            text: "Rust",
                        }
                        SkillItem {
                            img: asset!("/assets/skills/CPlusPlus.svg"),
                            text: "C++",
                        }
                        SkillItem {
                            img: asset!("/assets/skills/JS.svg"),
                            text: "JavaScript",
                        }
                        SkillItem {
                            img: asset!("/assets/skills/Elm.svg"),
                            text: "Elm",
                        }
                        SkillItem {
                            img: asset!("/assets/skills/godot.svg"),
                            text: "Godot",
                        }
                        SkillItem {
                            img: asset!("/assets/skills/bevy.svg"),
                            text: "Bevy",
                        }
                    }
                }
            }
        }
    }
}

#[derive(PartialEq, Clone, Props)]
struct RoleCardProps {
    class_name: String,
    title: String,
    children: Element,
}

#[allow(non_snake_case)]
fn RoleCard(props: RoleCardProps) -> Element {
    rsx! {
        div { class: "role-card",
            h3 {
                i { class: "fas fa-{props.class_name}" }
                "{props.title}"
            }
            p { {props.children} }
        }
    }
}

#[component]
fn SkillItem(img: Asset, text: String) -> Element {
    rsx! {
        div { class: "skill-item",
            img { class: "skill-icon", src: img, alt: text }
            span { "{text}" }
        }
    }
}
