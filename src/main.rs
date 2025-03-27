use dioxus::prelude::*;

mod components;

use components::*;

#[derive(Debug, Clone, Routable, PartialEq)]
#[rustfmt::skip]
enum Route {
    #[route("/")]
    Home {},
    #[route("/games/:gamename")]
    Blog { gamename: String },
}

const MAIN_CSS: Asset = asset!("/assets/main.css");

fn main() {
    dioxus::launch(App);
}

#[component]
fn App() -> Element {
    rsx! {
        document::Link {
            rel: "stylesheet",
            href: "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css",
        }
        document::Link { rel: "stylesheet", href: MAIN_CSS }
        Router::<Route> {}
    }
}

/// Blog page
#[component]
pub fn Blog(gamename: String) -> Element {
    rsx! {
        div { id: "blog",

            // Content
            h1 { "This is blog #{gamename}!" }
            p {
                "In blog #{gamename}, we show how the Dioxus router works and how URL parameters can be passed as props to our route components."
            }
        
        }
    }
}

// /// Shared navbar component.
// #[component]
// fn Navbar() -> Element {
//     rsx! {
//         div { id: "navbar",
//             "LTstrange"
//             Link { to: Route::Home {}, "Home" }
//             Link { to: Route::Blog { id: 1 }, "Blog" }
//         }

//         Outlet::<Route> {}
//     }
// }
