<?php

namespace App\Livewire;

use Livewire\Component;
use App\Models\Vozidlo;
use App\Models\Udrzba;

class ReportIssueAdd extends Component
{
    /* ATRIBUTES */

    /* data properties */
    public $vehicles;

    /* message properties*/
    public $nazov_spravy;
    public $spz;
    public $popis;
    

    /* FUNCTIONS */

    /* addVehicleIssue()
    DESCRIPTION:    - xxx
    */
    public function addVehicleIssue()
    {
        try { 
            // Validate input fields with custom error messages
            $validatedData = $this->validate([
                'nazov_spravy' => 'required|string',
                'spz' => 'required|string',
                'popis' => 'required|string',
            ], [
                'nazov_spravy.required' => 'Meno je povinné',
                'spz.required' => 'Priezvisko je povinné',
                'popis.required' => 'E-mail adresa je povinná',
            ]);

        // If validation fails, exception is caught and then is displayed error messages
        } catch (\Illuminate\Validation\ValidationException $e) {
            $messages = $e->validator->getMessageBag()->all();
            foreach ($messages as $message) {
                $this->dispatch('alert-error', message: $message);
            }
            return;

        // If there is any other exception, display basic error message
        } catch (\Exception $e) {
            $this->dispatch('alert-error', message: "ERROR - Input validation failed");
            return;
        }

        // Find the vehicle
        $vozidlo = Vozidlo::where('spz', $this->spz)->first();
        
        // If the vehicle is not found show message
        if (is_null($vozidlo)) {
            $this->dispatch('alert-error', message: "Vozidlo so zadanou ŠPZ neexistuje.");
            return;
        }

        // Insert row into the Udrzba table
        Udrzba::create([
            'id_vozidlo' => $vozidlo->id_vozidlo,
            'nazov_spravy' => $validatedData['nazov_spravy'], 
            'spz' => $validatedData['spz'], 
            'stav' => 'Vytvorená', 
            'popis' => $validatedData['popis']
        ]);
        
        // show success message
        $this->reset(['nazov_spravy', 'spz', 'popis']);
        $this->dispatch('alert-success', message: "Závada na vozidle bola nahlásená");
    }


    /* LIVEWIRE */

    /* - TODO - Add description */
    public function mount() {
        $this->vehicles = Vozidlo::all();
    }

    /* - Used for rendering the component in the browser */
    public function render()
    {
        return view('livewire.report-issue-add');
    }
}
