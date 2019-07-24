import "reflect-metadata";
import {createConnection} from "typeorm";
import * as express from "express";
import * as bodyParser from "body-parser";
import {Request, Response} from "express";
import {Routes} from "./routes";
import {User} from "./entity/User";

import * as helmet from 'helmet'
import * as morgan from 'morgan'
import * as fs from 'fs'
import * as path from 'path'

createConnection().then(async connection => {
    const app = express();
    app.use(helmet())
    app.use(morgan(':method :url :status :response-time ms - :res[content-length]'))
    app.use(bodyParser.json());
    
    Routes.forEach(route => {
        (app as any)[route.method](route.route, (req: Request, res: Response, next: Function) => {
            const result = (new (route.controller as any))[route.action](req, res, next);
            if (result instanceof Promise) {
                result.then(result => result !== null && result !== undefined ? res.send(result) : undefined);

            } else if (result !== null && result !== undefined) {
                res.json(result);
            }
        });
    });

    app.listen(3001);
    if (process.env.NODE_ENV === 'production') {
        app.use('/', express.static(path.join(__dirname, '../public')))
        app.get('*', (req, res) => {
            res.sendFile(path.join(__dirname, '../public/index.html'))
        })
    }

}).catch(error => console.log(error));
