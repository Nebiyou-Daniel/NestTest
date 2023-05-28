import { Injectable } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { PassportStrategy } from "@nestjs/passport";
import { ExtractJwt, Strategy } from "passport-jwt";
import { PrismaService } from "src/prisma/prisma.service";

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy){
    constructor(config: ConfigService, private prisma: PrismaService){
        super({
            jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
            loginExpiration: false,
            secretOrKey: config.get('JWT_SECRET'),
        })
    }

    async validate(payload: {sub: number, email: string, role:string}){
        const trainee = this.prisma.trainee.findUnique({
            where: {
                id: payload.sub,
            }
        })
        delete (await trainee).password;

        return trainee;
    }
}
