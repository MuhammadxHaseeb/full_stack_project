from fastapi import APIrouter, Depends, File, Form, UploadFile
from sqlalchemy.orm import Session
from database import get_db
from middleware.auth_middleware import auth_middleware
import cloudinary
import cloudinary.uploader
from cloudinary.utils import cloudinary_url

router = APIrouter()

# Configuration       
cloudinary.config( 
    cloud_name = "pgce46qm", 
    api_key = "588994627158111", 
    api_secret = cloudinary_api, # Click 'View API Keys' above to copy your API secret
    secure=True
)

@router.post('/upload')
def upload_song(song: UploadFile = File(...),
    thumbnail: UploadFile = File(...),
    artist: str = Form(...),
    song_name: str = Form(...),
    hex_code: str = Form(...),
    db: Session = Depends(get_db),
    auth_dict = Depends(auth_middleware)):

    pass