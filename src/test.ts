import { load, Humanize } from "./lib/BufImage"
import response from "./response"
import * as fs from 'fs';

const data = fs.readFileSync('./src/image.json', 'utf8');
const bufImage = load(data);

console.dir(bufImage.allTypes, {depth: null})

Humanize(bufImage, {}, "http://localhost:8080/greeter.Greeter/SayHello")

