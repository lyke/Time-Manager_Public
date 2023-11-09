import TM_clock from "../components/TM_clock";
import TM_container from "../components/TM_container";
import TM_totalHourCount from "../components/TM_totalHourCount";
import TM_dailyHourCount from "../components/TM_dailyHourCount";

export default function Dashboard() {

    return (
        <TM_container>
            <TM_clock/>
            <TM_dailyHourCount/>
            <TM_totalHourCount/>
        </TM_container>
    )
}
