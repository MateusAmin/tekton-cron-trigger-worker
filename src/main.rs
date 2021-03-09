use std::env;

fn main() {
    let mut args = env::args();
    args.next();
    for a in args {
        let mut stringy = "http://el-".to_owned();
        stringy.push_str(&a);
        stringy.push_str(".default.svc.cluster.local:8080");
        minreq::post(&stringy)
        .with_header("cron", "true")
        .send()
        .unwrap();
    }
}