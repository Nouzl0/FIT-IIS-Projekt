<?php

namespace App\Livewire;

use Livewire\Component;

class HomeAddSearch extends Component
{
    /* ATRIBUTES */

    /* Input field properties */
    public $busStop;      
    public $date;
    public $time;


    /* FUNCTIONS */

    /* searchAdd()
    DESCRIPTION:    - Function which searches for routes with given input data and then
                      redirects to the search page with the results
                    - Uses 'Input field' for getting input data

    TODO:           - Finish the function, (searching routes) & (redirecting to the search page with the results)
    */
    public function searchAdd()
    {
        try { 
            // Validate input fields with custom error messages
            $validatedData = $this->validate([
                'busStop' => 'required',
                'date' => 'required',
                'time' => 'required',
            ], [
                'busStop.required' => 'Zadajte zastávku',
                'date.required' => 'Zadajte dátum',
                'time.required' => 'Zadajte čas',
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
            $this->dispatch('alert-error', message: "ERROR - Validation failed");
            return;
        }
            
        /* TODO - After successful validation, search and create results of the search
                which will be displayed on search page, code bellow is just for testing
        */
        $departures = [
            0 => ['line' => '52', 'route' => 'Královo Pole, nádraží', 'time' => '15:53', 'date' => '18.11.2023'],
            1 => ['line' => '48', 'route' => 'Královo Pole, nádraží', 'time' => '16:53', 'date' => '18.11.2023'],
            2 => ['line' => '52', 'route' => 'Královo Pole, nádraží', 'time' => '17:53', 'date' => '18.11.2023'],
        ];

        // Rederict's to the search page with the searched results        
        $this->reset(['busStop', 'date', 'time']);
        session(['departuresResults' => $departures]);
        return redirect()->route('search');
    }


    /* LIVEWIRE */

    /* - Used for rendering the component in the browser */
    public function render()
    {
        return view('livewire.home-add-search');
    }
}
