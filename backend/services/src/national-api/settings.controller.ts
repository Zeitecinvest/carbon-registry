import {
  Body,
  Controller,
  Get,
  Post,
  Query,
  Request,
  UseGuards,
} from "@nestjs/common";
import { ApiBearerAuth, ApiTags } from "@nestjs/swagger";
import { Action } from "../shared/casl/action.enum";
import { JwtAuthGuard } from "carbon-services-lib";;
import { PoliciesGuardEx } from "../shared/casl/policy.guard";
import { SettingsDto } from "../shared/dto/settings.dto";
import { ConfigurationSettings } from "../shared/entities/configuration.settings";
import { ConfigurationSettingsService } from "carbon-services-lib";

@ApiTags("Settings")
@Controller("Settings")
@ApiBearerAuth()
export class SettingsController {
  constructor(
    private readonly configurationSettingsService: ConfigurationSettingsService
  ) {}

  @UseGuards(JwtAuthGuard, PoliciesGuardEx(true, Action.Update, ConfigurationSettings))
  @Post("update")
  async updateSettings(@Body() settings: SettingsDto, @Request() req) {
    return await this.configurationSettingsService.updateSetting(
      settings.id,
      settings.settingValue
    );
  }

  @UseGuards(JwtAuthGuard)
  @Get("query")
  async getSettings(@Query("id") settingsId: number, @Request() req) {
    return await this.configurationSettingsService.getSetting(settingsId);
  }
}
