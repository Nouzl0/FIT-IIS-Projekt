<?php

namespace App\Livewire;

use Livewire\Component;

class NavTechnician extends Component
{
    /* Variables */
    // empty (replace when needed)


    /* Back-end functions */
    // gets the current user's name from the session
    // todo - work on functionality
    public function get_login()
    {
        return "admin_acount";
    }

    // redirects to the home page and logs the user out
    // todo - work on functionality
    public function logout()
    {
        return redirect()->route('home');
    }

    /* Front-end functions */
    // empty (replace when needed)

    
    /* Rederictions */
    public function re_home() {
        return redirect()->route('home');
    }

    public function re_recordMaintenance() {
        return redirect()->route('recordMaintenance');
    }

    /* Render */
    public function render()
    {
        return view('livewire.nav-technician');
    }
}
