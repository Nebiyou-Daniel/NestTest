import { Body, Controller, Delete, Get, Patch, Req, UseGuards } from '@nestjs/common';
import { Trainee } from '@prisma/client';
import { GetTrainee } from 'src/auth/decorator';
import { JwtGuard } from 'src/auth/guard';
import { EditTraineeDto } from './dto';
import { TraineeService } from './trainee.service';
import { PasswordUpdateDto } from './dto/passwordUpdate.dto';

@UseGuards(JwtGuard)
@Controller('trainee')
export class TraineeController {
    constructor(private traineeService: TraineeService){}

    @Get('me')
    getMe(@GetTrainee() trainee: Trainee){ 
        return trainee;
    }

    @Patch('/profile')
    editTrainee(@GetTrainee('id') traineeId: number, @Body() dto: EditTraineeDto){
        return this.traineeService.updateTrainee(traineeId, dto);
    }
    @Patch('/password')
    updatePassword(@GetTrainee('id') traineeId: number, @Body() dto: PasswordUpdateDto){
        return this.traineeService.updatePassword(traineeId, dto);
    }
    @Delete()
    deleteTrainee(@GetTrainee('id') traineeId: number){
        return this.traineeService.deleteTrainee(traineeId);
    }
}