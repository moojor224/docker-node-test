import { exec } from "child-process"

console.log("Node process is running. Press Ctrl+C to stop.");

setInterval(() => {
    exec("chown -R git:git /var/lib/gitea/", (error, stdout, stderr) => {
        if (error) {
            console.error(`exec error: ${error}`);
            return;
        }
        if (stdout.length > 0) console.log(`stdout: ${stdout}`);
        if (stderr.length > 0) console.error(`stderr: ${stderr}`);
    });
}, 1000);