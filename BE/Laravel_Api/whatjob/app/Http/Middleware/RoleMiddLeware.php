<?php

namespace App\Http\Middleware;

use App\Models\Role;
use App\Models\User;
use App\Services\AccountService;
use App\Services\UserService;
use Closure;
use Exception;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RoleMiddLeware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next, ...$roles): Response
    {
        try {
            $token_id = AccountService::getIdToken($request->bearerToken());
            $user = ((User::where('token_id', $token_id))->get())->first();
            if($user){
                if($user->isBlock == 1){
                    return response()->json(['error' => 'Your account has been blocked'], 403);
                }
                $userrole = Role::find($user->role_id);
                foreach ($roles as $role) {

                    if ($role == $userrole->normalizeName ) {
                        return $next($request); // Pass the request to the next middleware or controller
                    }
                }
            }
            else{
                return response()->json(['error' => 'Expired tokens'], 403);
            }
        } catch (Exception $e) {
            echo $e;
        }
        return response()->json(['error' => 'Unauthorized'], 403);
    }
}
