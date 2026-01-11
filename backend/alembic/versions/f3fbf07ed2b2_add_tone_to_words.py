"""add_tone_to_words

Revision ID: f3fbf07ed2b2
Revises: 
Create Date: 2026-01-11 01:30:36.870731

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'f3fbf07ed2b2'
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # Create Tone enum type
    op.execute("""
        CREATE TYPE tone AS ENUM ('positive', 'negative', 'neutral')
    """)
    
    # Add tone column with default value
    op.add_column('words', sa.Column('tone', sa.Enum('positive', 'negative', 'neutral', name='tone'), nullable=False, server_default='neutral'))


def downgrade() -> None:
    # Remove tone column
    op.drop_column('words', 'tone')
    
    # Drop Tone enum type
    op.execute("DROP TYPE tone")
